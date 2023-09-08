# Ultroid - UserBot
# Copyright (C) 2021-2023 TeamUltroid
# This file is a part of < https://github.com/TeamUltroid/Ultroid/ >
# Please read the GNU Affero General Public License in <https://www.github.com/TeamUltroid/Ultroid/blob/main/LICENSE/>.

FROM theteamultroid/ultroid:main

# Set timezone
ENV TZ=Asia/Kolkata
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

COPY installer.sh .

RUN bash installer.sh

# Changing workdir
WORKDIR "/root/TeamUltroid"

# Expose the port your web server will run on (replace 8080 with the actual port)
EXPOSE 8080

# Start both the Ultroid UserBot and the web server using supervisord
RUN apt-get update && apt-get install -y supervisor
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

# Copy your web server script to the root directory of the container
COPY webserver.py .

CMD ["supervisord", "-c", "/etc/supervisor/conf.d/supervisord.conf"]
