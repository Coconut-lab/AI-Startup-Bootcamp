from django.db import models

class Supplement(models.Model):
    name = models.CharField(max_length=200)
    description = models.TextField()
    dosage = models.CharField(max_length=100)
    created_at = models.DateTimeField(auto_now_add=True)
    updated_at = models.DateTimeField(auto_now=True)

    def __str__(self):
        return self.name