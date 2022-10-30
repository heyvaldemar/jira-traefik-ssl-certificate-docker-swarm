# Jira with SSL Certificate in a Docker Swarm

Install Docker Swarm by following my [guide](https://www.heyvaldemar.com/install-docker-swarm-on-ubuntu-server/).

Configure Traefik and create secrets for storing the passwords on the Docker Swarm manager node before applying the configuration.

Traefik [configuration](https://github.com/heyValdemar/traefik-ssl-certificate-docker-swarm).

Create a secret for storing the password for Jira database using the command:

`printf "YourPassword" | docker secret create jira-postgres-password -`

Clear passwords from bash history using the command:

`history -c && history -w`

Run `jira-restore-application-data.sh` on the Docker Swarm worker node where the container for backups is running to restore application data if needed.

Run `jira-restore-database.sh` on the Docker Swarm node where the container for backups is running to restore database if needed.

Run `docker stack ps jira | grep jira_backups | awk 'NR > 0 {print $4}'` on the Docker Swarm manager node to find on which node container for backups is running.

Deploy Jira in a Docker Swarm using the command:

`docker stack deploy -c jira-traefik-ssl-certificate-docker-swarm.yml jira`

# Author

hey, I’m Vladimir Mikhalev, but my friends call me Valdemar.

🌐 My [website](https://www.heyvaldemar.com/) with detailed IT guides\
🎬 Follow me on [YouTube](https://www.youtube.com/channel/UCf85kQ0u1sYTTTyKVpxrlyQ?sub_confirmation=1)\
🐦 Follow me on [Twitter](https://twitter.com/heyValdemar)\
🎨 Follow me on [Instagram](https://www.instagram.com/heyvaldemar/)\
🎸 Follow me on [Facebook](https://www.facebook.com/heyValdemarFB/)\
🎥 Follow me on [TikTok](https://www.tiktok.com/@heyvaldemar)\
💻 Follow me on [LinkedIn](https://www.linkedin.com/in/heyvaldemar/)\
🐈 Follow me on [GitHub](https://github.com/heyvaldemar)

# Communication
👾 Chat with IT pros on [Discord](https://discord.gg/AJQGCCBcqf)\
📧 Reach me at ask@sre.gg

# Give Thanks
💎 Support on [GitHub](https://github.com/sponsors/heyValdemar)\
🏆 Support on [Patreon](https://www.patreon.com/heyValdemar)\
🥤 Support on [BuyMeaCoffee](https://www.buymeacoffee.com/heyValdemar)\
🍪 Support on [Ko-fi](https://ko-fi.com/heyValdemar)\
💖 Support on [PayPal](https://www.paypal.com/paypalme/heyValdemarCOM)
