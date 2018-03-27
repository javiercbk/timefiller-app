<template>
  <Page class="page">
    <ActionBar class="action-bar" title="Create worklog">
      <NavigationButton text="Go Back" android.systemIcon="ic_menu_back" @tap="$router.back()" />
    </ActionBar>
    <StackLayout class="form">
      <TextField keyboardType="number" v-model="hours"/>
    </StackLayout>
  </Page>
</template>
<script src="./worklog-create.js"></script>
