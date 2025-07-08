# GlitchTip Self-Hosted Example

This is a complete example setup for self-hosting GlitchTip, an open-source error tracking platform that's compatible with the Sentry API.

## What is GlitchTip?

GlitchTip is a simple, open source error tracking tool that serves as an alternative to Sentry. It's designed to be:
- **Simple**: Easy to set up and maintain
- **Cost-effective**: No usage-based pricing
- **Privacy-focused**: Keep your error data on your own infrastructure
- **Sentry-compatible**: Works with existing Sentry SDKs

## Quick Start

1. **Clone or download this repository**
   ```bash
   git clone <repository-url>
   cd glitchtip-self-hosted-example
   ```

2. **Set up environment variables**
   ```bash
   cp .env.example .env
   # Edit .env with your configuration
   ```

3. **Generate a secret key**
   ```bash
   openssl rand -hex 32
   # Copy the output to SECRET_KEY in .env
   ```

4. **Start the services**
   ```bash
   docker compose up -d
   ```

5. **Access GlitchTip**
   - Open http://localhost:8000 in your browser
   - Create your first user account

6. **Set up admin user (optional)**
   ```bash
   ./setup-admin.sh
   ```
   
   This creates an admin user with the following credentials:
   - Email: `admin@example.com`
   - Password: `admin123`
   
   **⚠️ Remember to change the password after first login!**

## Configuration

### Required Environment Variables

- `SECRET_KEY`: A long, random string for Django security
- `POSTGRES_PASSWORD`: Database password
- `GLITCHTIP_DOMAIN`: Your domain (for email links and CORS)

### Optional Configuration

- `DEBUG`: Set to `true` for development (default: `false`)
- `ENABLE_ORGANIZATION_CREATION`: Allow users to create organizations
- Email settings for notifications (SMTP configuration)

## Services

The Docker Compose setup includes:

- **PostgreSQL 17**: Primary database
- **Valkey 8**: Redis-compatible cache and message broker
- **GlitchTip Web**: Main application server
- **GlitchTip Worker**: Background task processor with Celery beat
- **Migration**: Automatic database migrations

## Usage

### Creating Your First Project

1. Access GlitchTip at http://localhost:8000
2. Sign up for a new account or use admin credentials (admin@example.com / admin123)
3. Create an organization
4. Create a project
5. Get your DSN from project settings
6. Configure your application to send errors to GlitchTip

### Default Admin Account

If you ran `./setup-admin.sh`, you can use these credentials:
- **Email**: `admin@example.com`
- **Password**: `admin123`

**Important**: Change this password immediately after first login for security!

### SDK Integration

GlitchTip is compatible with Sentry SDKs. Example for Python:

```python
import sentry_sdk

sentry_sdk.init(
    dsn="http://your-dsn@localhost:8000/1",
    traces_sample_rate=1.0,
)
```

## Maintenance

### Updating

```bash
docker compose pull
docker compose up -d
```

### Backup

```bash
# Backup database
docker compose exec postgres pg_dump -U glitchtip glitchtip > backup.sql

# Backup uploads
docker compose cp web:/code/uploads ./uploads-backup
```

### Monitoring

Check service health:
```bash
docker compose ps
docker compose logs web
```

## Production Considerations

- Use a reverse proxy (nginx) with SSL certificates
- Set up proper email configuration for notifications
- Configure regular backups
- Monitor disk space for database and uploads
- Set up log rotation
- Use strong passwords and keep SECRET_KEY secure

## Troubleshooting

- **Services won't start**: Check `docker compose logs` for errors
- **Database connection issues**: Ensure PostgreSQL is healthy
- **Email not working**: Verify SMTP configuration in .env
- **Performance issues**: Adjust CELERY_WORKER_CONCURRENCY based on your resources

## Resources

- [GlitchTip Documentation](https://glitchtip.com/documentation/)
- [GlitchTip GitHub](https://github.com/GlitchTip)
- [Sentry SDK Documentation](https://docs.sentry.io/)