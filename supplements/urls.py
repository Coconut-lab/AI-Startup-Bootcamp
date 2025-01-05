from django.urls import path
from rest_framework.routers import DefaultRouter
from .views import SupplementViewSet, ProfileViewSet

router = DefaultRouter()
router.register(r'supplements', SupplementViewSet, basename='supplement')
router.register(r'profile', ProfileViewSet, basename='profile')

urlpatterns = router.urls