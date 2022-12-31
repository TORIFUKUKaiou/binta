import Config

config :binta, slack_incoming_webhook_url: System.get_env("BINTA_SLACK_INCOMING_WEBHOOK_URL")
