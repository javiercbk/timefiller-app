<template>
  <Page class="page" :actionBarHidden="!isConfigured || !userLoaded" backgroundSpanUnderStatusBar="true">
    <StackLayout v-show="!userLoaded || !worklogsLoaded">
      <ActivityIndicator :busy="!userLoaded || !worklogsLoaded" horizontalAlignment="stretch" verticalAlignment="stretch"/>
    </StackLayout>
    <DockLayout v-show="worklogsLoaded && isConfigured" stretchLastChild="false">
      <StackLayout dock="top">
        <worklog-list></worklog-list>
      </StackLayout>
      <Button dock="bottom" class="btn btn-primary" text="Add worklog" @tap="navigateAddWorklog"/>
    </DockLayout>
    <DockLayout v-if="userLoaded && !isConfigured" stretchLastChild="false">
      <StackLayout dock="top">
        <Label class="h1 text-center">Welcome to Timefiller</Label>
        <Label class="p-10 body" :textWrap="true">In order to use this magnificient app you must first configure jira, harvest and wakatime</Label>
      </StackLayout>
      <Button dock="bottom" class="btn btn-primary" text="Configure" @tap="navigateConfiguration"/>
    </DockLayout>
  </Page>
</template>
<script src="./home.js"></script>

