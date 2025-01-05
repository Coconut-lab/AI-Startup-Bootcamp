from rest_framework import viewsets, status
from rest_framework.response import Response
from rest_framework.permissions import IsAuthenticated
from django.contrib.auth import get_user_model
from .models import Supplement
from .serializers import SupplementSerializer, UserSerializer

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