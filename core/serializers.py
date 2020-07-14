from rest_framework import serializers

from .models import *


class BookListSerializer(serializers.ModelSerializer):

    class Meta:
        model = Book
        fields = ("name", "description", "date", "rating")