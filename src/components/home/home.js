import { mapActions, mapGetters } from 'vuex';
import WorklogList from '../worklogs/worklog-list.vue';

export default {
  components: {
    WorklogList
  },
  data() {
    return {
      userLoaded: false,
      worklogsLoaded: false
    };
  },
  computed: {
    ...mapGetters('user', ['isConfigured'])
  },
  created() {
    console.log('loading user');
    this.load()
      .then(() => {
        this.userLoaded = true;
        console.log('loading worklogs');
        return this.loadWorklogs();
      })
      .then(() => {
        console.log('worklogs loaded');
        this.worklogsLoaded = true;
      });
  },
  methods: {
    ...mapActions('user', ['load']),
    ...mapActions('worklogs', ['loadWorklogs']),
    navigateAddWorklog() {
      this.$router.push({ name: 'add-worklog' });
    },
    navigateConfiguration() {
      this.$router.push({ name: 'configuration' });
    }
  }
};
