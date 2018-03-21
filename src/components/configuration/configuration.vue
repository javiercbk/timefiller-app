<template>
  <Page class="page">
    <ActionBar class="action-bar" :title="title">
      <NavigationButton v-if="isConfigured" text="Go Back" android.systemIcon="ic_menu_back" @tap="$router.back()" />
    </ActionBar>
    <StackLayout class="form">
      <Button class="btn btn-primary" text="Jira" @tap="navigateJira" horizontalAlignment="stretch" verticalAlignment="center"/>
      <Button class="btn btn-primary" text="Harvest" @tap="navigateHarvest" horizontalAlignment="stretch" verticalAlignment="center"/>
      <Button class="btn btn-primary" text="WakaTime" @tap="navigateWaka" horizontalAlignment="stretch" verticalAlignment="center"/>
      <Button class="btn btn-primary" text="Reminder" @tap="navigateReminder" horizontalAlignment="stretch" verticalAlignment="center"/>
    </StackLayout>
  </Page>
</template>
<script src="./configuration.js"></script>
