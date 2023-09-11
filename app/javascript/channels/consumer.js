// Action Cable provides the framework to deal with WebSockets in Rails.
// You can generate new channels where WebSocket features live using the `bin/rails generate channel` command.

import { createConsumer } from "@rails/actioncable"

consumer.subscriptions.create({ channel: "ApiUpdateChannel", room: `To_User_${current_user.id}` })

export default createConsumer()
