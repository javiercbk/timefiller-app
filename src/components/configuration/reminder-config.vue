<template>
  <Page class="page">
    <ActionBar class="action-bar" title="Reminder time">
      <NavigationButton text="Go Back" android.systemIcon="ic_menu_back" @tap="$router.back()" />
    </ActionBar>
    <StackLayout class="form">
      <StackLayout class="input-field">
        <Label class="label">Reminder time</Label>
        <TimePicker v-model="time" @timeChanged="onTimeChanged"></TimePicker>
      </StackLayout>
    </StackLayout>
  </Page>
</template>
<script src="./reminder-config.js"></script>
