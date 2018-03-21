<template>
  <ListView for="worklog in filteredWorklogs" @itemTap="onWorkflowTap">
    <Label :text="buildWorklogDescription(worklog)" />
  </ListView>
</template>
<script src="./worklog-list.js"></script>

