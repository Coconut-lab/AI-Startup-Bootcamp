from rest_framework import viewsets
from .models import Supplement
from .serializers import SupplementSerializer

class SupplementViewSet(viewsets.ModelViewSet):
    queryset = Supplement.objects.all().order_by('-created_at')
    serializer_class = SupplementSerializer