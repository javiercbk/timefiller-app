import Jira from './jira-client';
import { request } from '../request';

const JIRA_DATE_FORMAT = 'YYYY-MM-DDTHH:mm:ss.sssZZ';

class JiraFacade {
  constructor(configuration) {
    this.jira = new Jira({
      protocol: 'https',
      host: configuration.jira.host,
      username: configuration.jira.username,
      password: configuration.jira.password,
      apiVersion: '2',
      strictSSL: true,
      request
    });
  }

  addWorklog(issueId, date, seconds) {
    const header = {
      uri: this.jira.makeUri({
        pathname: `/issue/${issueId}/worklog`,
        query: { adjustEstimate: 'auto' }
      }),
      body: {
        started: date.format(JIRA_DATE_FORMAT),
        timeSpentSeconds: seconds
      },
      method: 'POST',
      'Content-Type': 'application/json',
      json: true
    };
    return this.jira.doRequest(header);
  }

  retrievedWorkLogged(date) {
    const now = date.startOf('day');
    const query = `worklogAuthor=currentUser() AND worklogDate = "${now.format('YYYY/MM/DD')}"`;
    const options = {
      startAt: 0,
      maxResults: 1000,
      fields: ['worklog', 'worklogs', 'status']
    };
    return this._exhaustIssues(query, options);
  }

  retrieveIssueByKey(key) {
    const query = `key="${key}"`;
    const options = {
      startAt: 0,
      maxResults: 1000,
      fields: ['worklog', 'worklogs', 'status']
    };
    return this._exhaustIssues(query, options);
  }

  assignableIssues(project, statuses = []) {
    let query = 'assignee=currentUser()';
    if (project) {
      query += ` AND project=${project}`;
    }
    if (statuses && statuses.length) {
      query += ' AND (';
      query += statuses.map(s => `status=${s}`).join(' OR ');
      query += ')';
    }
    const options = {
      startAt: 0,
      maxResults: 1000,
      fields: ['worklog', 'worklogs', 'status', 'summary']
    };
    return this._exhaustIssues(query, options);
  }

  _exhaustIssues(query, options, previousIssues = []) {
    return this.jira.searchJira(query, options).then((issuesResponse) => {
      const { issues } = issuesResponse;
      const allIssues = previousIssues.concat(issues);
      if (options.maxResults && issues.length === options.maxResults) {
        if (!options.startAt) {
          options.startAt = 0;
        }
        options.startAt += issues.length;
        return this._exhaustIssues(query, options, allIssues);
      }
      return allIssues;
    });
  }
}

module.exports = JiraFacade;
