import _ from 'lodash';
import { mapActions, mapGetters } from 'vuex';

export default {
  created() {
    Object.assign(this, this.jira);
  },
  data() {
    return {
      host: '',
      username: '',
      password: ''
    };
  },
  watch: {
    host() {
      this.saveConfig();
    },
    username() {
      this.saveConfig();
    },
    password() {
      this.saveConfig();
    }
  },
  computed: {
    ...mapGetters('user', ['jira'])
  },
  methods: {
    ...mapActions('user', ['setJira']),
    saveConfig() {
      this.setJira(_.pick(this, ['host', 'username', 'password']));
    }
  }
};
