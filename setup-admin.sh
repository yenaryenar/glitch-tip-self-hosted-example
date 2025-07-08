#!/bin/bash

# GlitchTip Admin User Setup Script

set -e

echo "Setting up GlitchTip admin user..."

# Create superuser
echo "Creating admin user..."
docker compose exec web ./manage.py createsuperuser --email admin@example.com --noinput

# Set password
echo "Setting password..."
docker compose exec web python -c "
import os
import django
os.environ.setdefault('DJANGO_SETTINGS_MODULE', 'glitchtip.settings')
django.setup()
from django.contrib.auth import get_user_model
User = get_user_model()
user = User.objects.get(email='admin@example.com')
user.set_password('admin123')
user.save()
print('Password set successfully for admin@example.com')
"

echo ""
echo "✅ Admin user created successfully!"
echo ""
echo "Login credentials:"
echo "  Email: admin@example.com"
echo "  Password: admin123"
echo ""
echo "Access GlitchTip at: http://localhost:8000"
echo ""
echo "⚠️  Remember to change the password after first login!"