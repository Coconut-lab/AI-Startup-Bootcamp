from rest_framework import serializers
from django.contrib.auth import get_user_model

User = get_user_model()

class UserSerializer(serializers.ModelSerializer):
    class Meta:
        model = User
        fields = ['id', 'username', 'email', 'password']
        extra_kwargs = {
            'password': {'write_only': True},  # 패스워드는 읽기 불가능하게 설정
            'id': {'read_only': True}  # id는 자동 생성되므로 읽기 전용
        }

    def create(self, validated_data):
        # 비밀번호 해싱을 위해 create_user 메서드 사용
        user = User.objects.create_user(
            username=validated_data['username'],
            email=validated_data['email'],
            password=validated_data['password']
        )
        return user

    def update(self, instance, validated_data):
        # 비밀번호가 포함된 경우 별도 처리
        if 'password' in validated_data:
            password = validated_data.pop('password')
            instance.set_password(password)
        
        return super().update(instance, validated_data)