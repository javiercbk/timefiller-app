<template>
  <Page class="page">
    <ActionBar class="action-bar" title="Configuration">
      <NavigationButton text="Go Back" android.systemIcon="ic_menu_back" @tap="$router.back()" />
    </ActionBar>
    <StackLayout class="form">
      <StackLayout class="input-field">
        <Label class="label">API key</Label>
        <TextField v-model="apiKey" class="input"></TextField>
      </StackLayout>
    </StackLayout>
  </Page>
</template>
<script src="./waka-config.js"></script>
