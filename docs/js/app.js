var app = new Vue({
  el: '#app',
  data: {
    connpass_groups: [],
    doorkeeper_groups: []
  },
  methods: {
    getConnpassGroups: function () {
      var url = 'config/connpass.json';
      var that = this;
      axios.get(url).then(function (x) {
        that.connpass_groups = x.data.groups.map(function (group) {
          group.url = "https://" + group.id + ".connpass.com/";
          return group;
        }).sort(function (a, b) {
          return that.compareString(a.name, b.name);
        });
      });
    },

    getDoorkeeperGroups: function () {
      var url = 'config/doorkeeper.json';
      var that = this;
      axios.get(url).then(function (x) {
        that.doorkeeper_groups = x.data.groups.map(function (group) {
          group.url = "https://" + group.id + ".doorkeeper.jp/";
          return group;
        }).sort(function (a, b) {
          return that.compareString(a.name, b.name);
        });
      });
    },

    compareString: function (a, b) {
      a = a.toUpperCase();
      b = b.toUpperCase();
      if (a < b) {
        return -1;
      }
      if (a > b) {
        return 1;
      }
      return 0;
    }
  },
  mounted: function () {
    this.getConnpassGroups();
    this.getDoorkeeperGroups();
  }
});
