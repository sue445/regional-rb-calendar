const fetchJson = async (url) => {
  const response = await fetch(url);
  if (!response.ok) {
    throw new Error(`HTTP error! status: ${response.status}`);
  }
  return await response.json();
};

const app = Vue.createApp({
  data() {
    return {
      connpassGroups: [],
      doorkeeperGroups: [],
    };
  },
  methods: {
    async getConnpassGroups() {
      try {
        const data = await fetchJson('config/connpass.json');
        this.connpassGroups = data.groups.map((group) => ({
          ...group,
          url: `https://${group.id}.connpass.com/`,
        })).sort((a, b) => this.compareString(a.name, b.name));
      } catch (error) {
        console.error('Error fetching Connpass groups:', error);
      }
    },
    async getDoorkeeperGroups() {
      try {
        const data = await fetchJson('config/doorkeeper.json');
        this.doorkeeperGroups = data.groups.map((group) => ({
          ...group,
          url: `https://${group.id}.doorkeeper.jp/`,
        })).sort((a, b) => this.compareString(a.name, b.name));
      } catch (error) {
        console.error('Error fetching Doorkeeper groups:', error);
      }
    },
    compareString(a, b) {
      a = a.toUpperCase();
      b = b.toUpperCase();
      if (a < b) {
        return -1;
      }
      if (a > b) {
        return 1;
      }
      return 0;
    },
  },
  mounted() {
    this.getConnpassGroups();
    this.getDoorkeeperGroups();
  },
});

app.mount('#app');
