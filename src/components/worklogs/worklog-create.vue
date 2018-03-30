<template>
  <Page class="page">
    <ActionBar class="action-bar" title="Create worklog">
      <NavigationButton text="Go Back" android.systemIcon="ic_menu_back" @tap="$router.back()" />
    </ActionBar>
    <StackLayout v-show="loadingIssues">
      <ActivityIndicator :busy="loadingIssues" horizontalAlignment="stretch" verticalAlignment="stretch"/>
    </StackLayout>
    <DockLayout stretchLastChild="false" v-show="!loadingIssues">
      <ScrollView dock="top" style="height:80%">
        <StackLayout class="form">
          <Label textWrap="true" class="h2 font-weight-bold" text="Worklog date"/>
          <DatePicker v-model="worklog.date" />
          <Label :text="worklogLabel" class="h2 font-weight-bold text-danger" :class="{'text-danger': !isHoursValid}"/>
          <TextField class="input" :class="{'text-danger': !isHoursValid}" keyboardType="number" v-model.number="worklog.hours" hint="Hours" autocorrect="false"/>
          <Label textWrap="true" class="h2" :class="{'text-danger': !isIssueValid}">
            <FormattedString>
              <Span text="Ticket: "/>
              <Span :text="chosenIssue"/>
            </FormattedString>
          </Label>
          <ListPicker :items="openIssues" v-model="selectedIssueIndex" />
          <TextField class="input" :class="{'text-danger': !isIssueValid}" v-model="worklog.issueKey" hint="Issue key" autocorrect="false" v-if="selectedIssue === 'Other'"/>
        </StackLayout>
      </ScrollView>
      <Button dock="bottom" class="btn btn-primary" :isEnabled="isValid" text="Create" @tap="saveWorklog" style="height:20%"/>
    </DockLayout>
  </Page>
</template>
<script src="./worklog-create.js"></script>
