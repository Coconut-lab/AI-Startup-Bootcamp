from django.contrib import admin
from django.urls import path, include
from rest_framework.routers import DefaultRouter
from supplements.views import SupplementViewSet

router = DefaultRouter()
router.register(r'supplements', SupplementViewSet)

urlpatterns = [
    path('admin/', admin.site.urls),
    path('api/', include(router.urls)),
]