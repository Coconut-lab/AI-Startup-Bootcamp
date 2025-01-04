from django.contrib import admin
from django.urls import path, include
from django.shortcuts import redirect
from rest_framework.routers import DefaultRouter
from supplements.views import SupplementViewSet

router = DefaultRouter()
router.register(r'supplements', SupplementViewSet)

# 루트 URL을 리스트 페이지로 리다이렉트하는 함수
def redirect_to_list(request):
    return redirect('supplement_list')

urlpatterns = [
    path('', redirect_to_list, name='root'),  # 루트 URL 처리 추가
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
    path('supplements/', include('supplements.urls')),
]