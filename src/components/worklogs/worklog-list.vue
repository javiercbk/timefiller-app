<template>
  <StackLayout class="form">
    <Label text="No worklogs created" v-show="!filteredWorklogs.length"/>
    <ListView v-show="filteredWorklogs.length" for="worklog in filteredWorklogs" @itemTap="onWorkflowTap">
      <v-template>
        <Label :text="buildWorklogDescription(worklog)" />
      </v-template>
    </ListView>
  </StackLayout>
</template>
<script src="./worklog-list.js"></script>

