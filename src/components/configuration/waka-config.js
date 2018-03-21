import { mapActions, mapGetters } from 'vuex';

export default {
  created() {
    Object.assign(this, this.waka);
  },
  data() {
    return {
      apiKey: ''
    };
  },
  watch: {
    apiKey() {
      this.saveConfig();
    }
  },
  computed: {
    ...mapGetters('user', ['waka'])
  },
  methods: {
    ...mapActions('user', ['setWaka']),
    saveConfig() {
      this.setWaka({
        apiKey: this.apiKey
      });
    }
  }
};
