import { mapGetters } from 'vuex';

export default {
  props: {
    maxLen: {
      type: Number,
      default: 10
    }
  },
  computed: {
    ...mapGetters('worklogs', ['worklogs']),
    filteredWorklogs() {
      return this.worklogs.slice(0, this.maxLen);
    }
  },
  methods: {
    buildWorklogDescription(worklog) {
      return `${worklog.ticket.number} (${worklog.hours}h): ${worklog.ticket.title}`;
    },
    onWorkflowTap(worklog) {
      this.$router.push({ name: 'worklog-detail', params: { worklogId: worklog.id } });
    }
  }
};
