<template>
  <Page class="page">
    <ActionBar class="action-bar" title="Configuration">
      <NavigationButton text="Go Back" android.systemIcon="ic_menu_back" @tap="$router.back()" />
    </ActionBar>
    <StackLayout class="form">
      <StackLayout class="input-field">
        <Label class="label">Subdomain</Label>
        <TextField v-model="subdomain" hint="company" class="input" autocorrect="false"></TextField>
      </StackLayout>
      <StackLayout class="input-field">
        <Label class="label">Email</Label>
        <TextField v-model="email" class="input" keyboardType="email" autocorrect="false"></TextField>
      </StackLayout>
      <StackLayout class="input-field">
        <Label class="label">Password</Label>
        <TextField v-model="password" :secure="true" class="input" autocorrect="false"></TextField>
      </StackLayout>
    </StackLayout>
  </Page>
</template>
<script src="./harvest-config.js"></script>
