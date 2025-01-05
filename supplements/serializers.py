from rest_framework import serializers
from django.contrib.auth import get_user_model
from .models import Supplement, Storage, StorageItem

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password']
        extra_kwargs = {
            'password': {'write_only': True},
            'id': {'read_only': True}
        }

    def create(self, validated_data):
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']
        )
        return user

    def update(self, instance, validated_data):
        if 'password' in validated_data:
            password = validated_data.pop('password')
            instance.set_password(password)
        
        return super().update(instance, validated_data)

class SupplementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Supplement
        fields = '__all__'

class StorageSerializer(serializers.ModelSerializer):
    class Meta:
        model = Storage
        fields = ['id', 'name', 'description', 'created_at', 'updated_at']
        read_only_fields = ['created_at', 'updated_at']

class StorageItemSerializer(serializers.ModelSerializer):
    supplement_name = serializers.CharField(source='supplement.name', read_only=True)

    class Meta:
        model = StorageItem
        fields = ['id', 'storage', 'supplement', 'supplement_name', 'quantity', 'added_at']
        read_only_fields = ['added_at']