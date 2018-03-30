import moment from 'moment';

const issueKeyRegexp = /[a-zA-Z]+-[0-9]+/;

export const worklogValidationErrors = (worklog) => {
  const errors = [];
  if (!worklog.hours) {
    errors.push({ message: 'Worklog must have hours', props: { hours: { val: worklog.hours } } });
  } else if (Number.isNaN(parseInt(worklog.hours, 10)) || worklog.hours <= 0) {
    errors.push({
      message: 'Worklog must have a positive number of hours',
      props: { hours: { val: worklog.hours } }
    });
  }
  const worklogMoment = moment(worklog.date);
  if (!worklog.date) {
    errors.push({ message: 'Worklog must have a date', props: { date: { val: worklog.date } } });
  } else if (!worklogMoment.isValid()) {
    errors.push({
      message: 'Worklog must have valid date',
      props: { date: { val: worklog.date } }
    });
  }
  if (!worklog.issueKey) {
    errors.push({
      message: 'Worklog must have an issue key',
      props: { issueKey: { val: worklog.issueKey } }
    });
  } else if (!issueKeyRegexp.test(worklog.issueKey)) {
    errors.push({
      message: 'Worklog must have a valid issue key with pattern [a-zA-Z]+-[0-9]',
      props: { issueKey: { val: worklog.issueKey } }
    });
  }
  return errors;
};
