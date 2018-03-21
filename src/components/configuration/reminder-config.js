import { mapActions, mapGetters } from 'vuex';
import moment from 'moment';

const DEFAULT_DATE = moment('1899-12-31T10:00:00:000', 'YYYY-MM-DDTHH:mm:ss.sss');

export default {
  mounted() {
    console.log(`this.reminder => ${JSON.stringify(this.reminder)}`);
    if (this.reminder && this.reminder.hour !== undefined && this.reminder.minute !== undefined) {
      let parsedTime = this.parsedTime.clone();
      parsedTime = parsedTime.minute(this.reminder.minute);
      parsedTime = parsedTime.hour(this.reminder.hour);
      console.log(`Will set time ${parsedTime.format()}`);
      this.time = parsedTime.toDate();
    }
  },
  data() {
    return {
      time: DEFAULT_DATE.toDate()
    };
  },
  watch: {
    hour() {
      this.saveConfig();
    },
    minute() {
      this.saveConfig();
    }
  },
  computed: {
    ...mapGetters('user', ['reminder']),
    parsedTime() {
      return moment(this.time, 'YYYY-MM-DDTHH:mm:ss.sss');
    },
    hour() {
      return this.parsedTime.hour();
    },
    minute() {
      return this.parsedTime.minute();
    }
  },
  methods: {
    ...mapActions('user', ['setReminder']),
    onTimeChanged(newTime) {
      console.log(`time has changed to ${newTime}`);
    },
    saveConfig() {
      console.log(`setting reminder at ${this.hour}:${this.minute}`);
      this.setReminder({
        hour: this.hour,
        minute: this.minute
      });
    }
  }
};
