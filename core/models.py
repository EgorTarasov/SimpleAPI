from django.db import models

# Create your models here.


class Student(models.Model):
    name = models.CharField(
        max_length=128,
        default=' '
    )
    age = models.IntegerField(
        default='7'
    )


class Teacher(models.Model):
    name = models.CharField(
        max_length=128,
        default=' '
    )
    age = models.IntegerField(
        default='7'
    )


class Book(models.Model):
    name = models.CharField(
        max_length=128,
        default=' '
    )
    description = models.CharField(
        max_length=256,
        default=' '
    )
    '''
    cover = models.ImageField(
        default=' ',
        upload_to='covers/'
    )
    '''
    date = models.DateField()
    rating = models.FloatField(
        default=0.0
    )


class Author(models.Model):
    first_name = models.CharField(
        max_length=128,
        default=' '
    )
    second_name = models.CharField(
        max_length=128,
        default=' '
    )
    avatar = models.ImageField(
        "Изображение",
        upload_to="authors/"
    )
    books = models.ManyToManyField(Book)


