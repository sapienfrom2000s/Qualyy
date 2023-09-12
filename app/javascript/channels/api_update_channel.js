import consumer from "channels/consumer"

consumer.subscriptions.create({channel: "ApiUpdateChannel", room: "To_User"}, {
  connected() {
    console.log('blabla')
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    console.log('hello i was called');
  }
});
