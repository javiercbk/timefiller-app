import { mapActions, mapGetters } from 'vuex';

export default {
  data() {
    return {
      userLoaded: false
    };
  },
  computed: {
    ...mapGetters('user', ['isConfigured'])
  },
  created() {
    this.load().then(() => {
      this.userLoaded = true;
    });
  },
  methods: {
    ...mapActions('user', ['load']),
    navigateConfiguration() {
      this.$router.push({ name: 'configuration' });
    }
  }
};
