# nexaera_chat

## Run the web app

```bash
flutter run -d chrome --web-port=55341
```

- this will make sure we don't get any CORS problems, as this port is accepted by the Django API running with `docker-compose`
