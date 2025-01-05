from django.contrib.auth.models import AbstractUser, Group, Permission
from django.db import models

class User(AbstractUser):
    groups = models.ManyToManyField(
        Group,
        related_name='supplement_users',
        blank=True,
        help_text='The groups this user belongs to.',
        verbose_name='groups'
    )
    user_permissions = models.ManyToManyField(
        Permission,
        related_name='supplement_users_permissions',
        blank=True,
        help_text='Specific permissions for this user.',
        verbose_name='user permissions'
    )

class Profile(models.Model):
    user = models.OneToOneField(User, on_delete=models.CASCADE, related_name='profile')
    # 필요한 프로필 필드 추가
    bio = models.TextField(blank=True)
    birth_date = models.DateField(null=True, blank=True)
    # 추가하고 싶은 다른 프로필 필드들...

    def __str__(self):
        return f"{self.user.username}'s profile"

class Supplement(models.Model):
    name = models.CharField(max_length=200)
    description = models.TextField()
    dosage = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name