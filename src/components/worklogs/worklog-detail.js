import { mapGetters } from 'vuex';
import moment from 'moment';

export default {
  computed: {
    ...mapGetters('worklogs', ['worklogs']),
    worklog() {
      return this.worklogs.find(w => w.id === this.worklogId);
    },
    ticketNumber() {
      if (this.worklog) {
        return this.worklog.ticket.number;
      }
      return '';
    },
    hours() {
      if (this.worklog) {
        return this.worklog.hours;
      }
      return 0;
    },
    date() {
      if (this.worklog) {
        return moment
          .utc(this.worklog.date)
          .local()
          .format();
      }
      return '';
    }
  }
};
