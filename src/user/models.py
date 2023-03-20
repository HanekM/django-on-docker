from django.db import models
from django.utils.translation import gettext as _
from django.contrib.auth.models import AbstractUser

from user.managers import CustomUserManager


class User(AbstractUser):
    # Model configuration
    EMAIL_FIELD = "email"
    USERNAME_FIELD = "email"
    REQUIRED_FIELDS = []
    # Custom object manager
    objects = CustomUserManager()

    # Overridden AbstractUser's fields
    username = None
    email = models.EmailField(_("email address"), unique=True, max_length=64)

    class Meta:
        ordering = ("-id",)
        verbose_name = _("user")
        verbose_name_plural = _("users")
        db_table = "users"
        abstract = False

    def __str__(self) -> str:
        return f"#{self.id} {self.email}"
