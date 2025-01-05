from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from rest_framework.decorators import action
from django.contrib.auth import get_user_model
from .models import Supplement, Storage, StorageItem
from .serializers import SupplementSerializer, UserSerializer, StorageSerializer, StorageItemSerializer

User = get_user_model()

class SupplementViewSet(viewsets.ModelViewSet):
    queryset = Supplement.objects.all().order_by('-created_at')
    serializer_class = SupplementSerializer

class ProfileViewSet(viewsets.ModelViewSet):
    permission_classes = [IsAuthenticated]
    serializer_class = UserSerializer
    queryset = User.objects.all()  # queryset 추가

    def get_object(self):
        return self.request.user

    def retrieve(self, request, *args, **kwargs):
        """사용자 프로필 정보 조회"""
        user = self.get_object()
        serializer = self.get_serializer(user)
        return Response(serializer.data)

    def update(self, request, *args, **kwargs):
        """사용자 프로필 정보 수정"""
        user = self.get_object()
        serializer = self.get_serializer(user, data=request.data, partial=True)
        if serializer.is_valid():
            serializer.save()
            return Response({
                'message': '프로필이 성공적으로 수정되었습니다.',
                'data': serializer.data
            })
        return Response(serializer.errors, status=status.HTTP_400_BAD_REQUEST)

    def list(self, request, *args, **kwargs):
        """현재 로그인한 사용자의 프로필 정보 조회"""
        user = self.request.user
        serializer = self.get_serializer(user)
        return Response(serializer.data)
    
    from rest_framework import viewsets, status
from rest_framework.decorators import action
from rest_framework.response import Response
from .models import Storage, StorageItem
from .serializers import StorageSerializer, StorageItemSerializer

class StorageViewSet(viewsets.ModelViewSet):
    serializer_class = StorageSerializer
    permission_classes = [IsAuthenticated]

    def get_queryset(self):
        """현재 사용자의 서랍장만 반환"""
        return Storage.objects.filter(user=self.request.user)

    def perform_create(self, serializer):
        """서랍장 생성시 현재 사용자 연결"""
        serializer.save(user=self.request.user)

    @action(detail=True, methods=['post'])
    def add_supplement(self, request, pk=None):
        """서랍장에 영양제 추가"""
        storage = self.get_object()
        supplement_id = request.data.get('supplement_id')
        quantity = request.data.get('quantity', 1)

        try:
            supplement = Supplement.objects.get(id=supplement_id)
            storage_item, created = StorageItem.objects.get_or_create(
                storage=storage,
                supplement=supplement,
                defaults={'quantity': quantity}
            )
            if not created:
                storage_item.quantity += quantity
                storage_item.save()
            
            serializer = StorageItemSerializer(storage_item)
            return Response(serializer.data)
        except Supplement.DoesNotExist:
            return Response(
                {"error": "영양제를 찾을 수 없습니다."},
                status=status.HTTP_404_NOT_FOUND
            )

    @action(detail=True, methods=['get'])
    def supplements(self, request, pk=None):
        """서랍장의 영양제 목록 조회"""
        storage = self.get_object()
        items = StorageItem.objects.filter(storage=storage)
        serializer = StorageItemSerializer(items, many=True)
        return Response(serializer.data)