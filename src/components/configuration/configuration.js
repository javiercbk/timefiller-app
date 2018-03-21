import { mapGetters } from 'vuex';

export default {
  computed: {
    ...mapGetters('user', ['isConfigured']),
    isInMainView() {
      return this.$route.name === 'configuration';
    },
    title() {
      switch (this.$route.name) {
        case 'configuration':
          return 'Configuration';
        case 'config-jira':
          return 'Jira';
        case 'config-harvest':
          return 'Harvest';
        case 'config-waka':
          return 'WakaTime';
        default:
          return 'Unknown';
      }
    }
  },
  methods: {
    navigateJira() {
      this.$router.push({ name: 'config-jira' });
    },
    navigateHarvest() {
      this.$router.push({ name: 'config-harvest' });
    },
    navigateWaka() {
      this.$router.push({ name: 'config-waka' });
    },
    navigateReminder() {
      this.$router.push({ name: 'config-reminder' });
    }
  }
};
