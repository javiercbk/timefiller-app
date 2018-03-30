import moment from 'moment';
import { mapGetters } from 'vuex';
import JiraFacade from '../../lib/jira';
import { worklogValidationErrors } from './worklog-create-validator';

const PROJECT = 'PRJ';

export default {
  created() {
    this.jiraFacade = new JiraFacade({ jira: this.jira });
    console.log('retrieving issues');
    this.jiraFacade
      .assignableIssues(PROJECT, ['DEV-IN-PROGRESS', 'DEV-DONE'])
      .then((issues) => {
        console.log(`issues => ${JSON.stringify(issues)}`);
        this.loadingIssues = false;
        this.issues = this.issues.concat(issues);
      })
      .catch((err) => {
        console.log(`Error retrieving issues raw ${err}`);
        console.log(`error retrieving issues => ${JSON.stringify(err)}`);
        this.loadingIssues = false;
      });
  },
  data() {
    return {
      worklog: {
        date: new Date(),
        hours: 8,
        issueKey: ''
      },
      loadingIssues: true,
      issues: [{ key: 'Other' }],
      selectedIssueIndex: 0
    };
  },
  watch: {
    selectedIssueIndex(index) {
      this.worklog.issueKey = this.issues[index];
    }
  },
  computed: {
    ...mapGetters('user', ['jira']),
    worklogLabel() {
      return `Hours worked at ${moment(this.date).format('YYYY-MM-DD')}`;
    },
    numberValid() {
      return !Number.isNaN(parseInt(this.hours, 10)) && this.hours > 0;
    },
    validationErrors() {
      return worklogValidationErrors(this.worklog);
    },
    isHoursValid() {
      return this.validationErrors.find(e => e.props.hours) === undefined;
    },
    isIssueValid() {
      return this.validationErrors.find(e => e.props.issueKey) === undefined;
    },
    isValid() {
      return this.validationErrors.length === 0;
    },
    openIssues() {
      return this.issues.map(t => t.key);
    },
    selectedIssue() {
      return this.issues[this.selectedIssueIndex].key;
    },
    chosenIssue() {
      if (!this.worklog.issueKey) {
        return this.selectedIssue;
      }
      return this.worklog.issueKey;
    }
  },
  methods: {
    saveWorklog() {}
  }
};
