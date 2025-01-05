from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from supplements.views import SupplementViewSet, ProfileViewSet, StorageViewSet  # StorageViewSet 추가
from django.shortcuts import redirect

router = DefaultRouter()
router.register(r'supplements', SupplementViewSet, basename='supplement')
router.register(r'profile', ProfileViewSet, basename='profile')
router.register(r'storages', StorageViewSet, basename='storage')

def redirect_to_api(request):
    return redirect('/api/')

urlpatterns = [
    path('', redirect_to_api, name='root'),
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
]