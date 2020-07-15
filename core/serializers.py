from rest_framework import serializers

from .models import *


class BookListSerializer(serializers.ModelSerializer):

    class Meta:
        model = Book
        fields = ("name", "description", "date", "rating")


class EventListSerializer(serializers.ModelSerializer):

    class Meta:
        model = Event
        fields = ("event_name", "event_description", "event_address", "event_date")