<template>
  <Page class="page">
    <ActionBar class="action-bar" title="Worklog detail">
      <NavigationButton text="Go Back" android.systemIcon="ic_menu_back" @tap="$router.back()" />
    </ActionBar>
    <Label text="The workflow thas not exist" class="h2" textWrap="true" v-show="!worklog"/>
    <StackLayout class="form" v-show="worklog">
      <Label textWrap="true" class="h2">
        <FormattedString>
          <Span text="Ticket: " fontWeight="bold"/>
          <Span :text="worklog.ticket.number"/>
        </FormattedString>
      </Label>
      <Label textWrap="true" class="h3">
        <FormattedString>
          <Span text="Hours: " fontWeight="bold"/>
          <Span :text="worklog.hours"/>
        </FormattedString>
      </Label>
      <Label textWrap="true" class="h3">
        <FormattedString>
          <Span text="Date: " fontWeight="bold"/>
          <Span :text="date"/>
        </FormattedString>
      </Label>
    </StackLayout>
  </Page>
</template>
<script src="./worklog-detail.js"></script>
