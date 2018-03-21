<template>
  <Page class="page" actionBarHidden="true" backgroundSpanUnderStatusBar="true">
    <StackLayout v-show="!userLoaded">
      <ActivityIndicator :busy="!userLoaded" horizontalAlignment="stretch" verticalAlignment="stretch"/>
    </StackLayout>
    <DockLayout v-show="userLoaded" stretchLastChild="false">
      <StackLayout dock="top">
        <Label class="h1 text-center">Welcome to Timefiller</Label>
        <Label class="p-10 body" :textWrap="true">In order to use this magnificient piece of software you must first configure the application</Label>
      </StackLayout>
      <Button dock="bottom" class="btn btn-primary" text="Configure" @tap="navigateConfiguration"/>
    </DockLayout>
  </Page>
</template>
<script src="./home.js"></script>

