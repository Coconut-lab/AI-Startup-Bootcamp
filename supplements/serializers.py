from rest_framework import serializers
from .models import Supplement

class SupplementSerializer(serializers.ModelSerializer):
    class Meta:
        model = Supplement
        fields = ['id', 'name', 'description', 'dosage', 'created_at', 'updated_at']