from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from supplements.views import SupplementViewSet, ProfileViewSet
from django.shortcuts import redirect

router = DefaultRouter()
router.register(r'supplements', SupplementViewSet, basename='supplement')
router.register(r'profile', ProfileViewSet, basename='profile')  # basename 추가

# 루트 URL에 대한 리다이렉트 함수
def redirect_to_api(request):
    return redirect('/api/')

urlpatterns = [
    path('', redirect_to_api, name='root'),
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
]