from django.contrib import admin
from django.conf import settings
from django.urls import path
from django.contrib.staticfiles.urls import staticfiles_urlpatterns

from config.views import current_datetime

urlpatterns = [
    path("admin/", admin.site.urls),
    path("now/", current_datetime, name="current-datetime"),
]

if bool(settings.DEBUG):
    urlpatterns += staticfiles_urlpatterns()
