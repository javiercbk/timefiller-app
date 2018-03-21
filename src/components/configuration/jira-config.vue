<template>
  <Page class="page">
    <ActionBar class="action-bar" title="Configuration">
      <NavigationButton text="Go Back" android.systemIcon="ic_menu_back" @tap="$router.back()" />
    </ActionBar>
    <StackLayout class="form">
      <StackLayout class="input-field">
        <Label class="label">Host</Label>
        <TextField v-model="host" hint="company.atlassian.net" class="input"></TextField>
      </StackLayout>
      <StackLayout class="input-field">
        <Label class="label">Username</Label>
        <TextField v-model="username" class="input"></TextField>
      </StackLayout>
      <StackLayout class="input-field">
        <Label class="label">Password</Label>
        <TextField v-model="password" :secure="true" class="input"></TextField>
      </StackLayout>
    </StackLayout>
  </Page>
</template>
<script src="./jira-config.js"></script>
