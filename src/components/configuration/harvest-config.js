import _ from 'lodash';
import { mapActions, mapGetters } from 'vuex';

export default {
  created() {
    Object.assign(this, this.harvest);
  },
  data() {
    return {
      subdomain: '',
      email: '',
      password: ''
    };
  },
  watch: {
    subdomain() {
      this.saveConfig();
    },
    email() {
      this.saveConfig();
    },
    password() {
      this.saveConfig();
    }
  },
  computed: {
    ...mapGetters('user', ['harvest'])
  },
  methods: {
    ...mapActions('user', ['setHarvest']),
    saveConfig() {
      this.setHarvest(_.pick(this, ['subdomain', 'email', 'password']));
    }
  }
};
