# A simple plan that prints a greeting message to the console.
plan demo::hello(
    TargetSpec $nodes,
    String $name = "World"
) {
    # Upload a file from the module_name/path/to/file -> /path/on/node
    $upload_path = '/opt/sayhello.txt'
    upload_file('demo/files/sayhello.txt', "${upload_path}", $nodes)

    # You can run a command
    $cmd1 = run_command("cat ${upload_path}", $nodes)
    if !$cmd1.ok {
        return fail("run_cmd executed with error: ${cmd1.error}")
    }
    notice("cat>>>: ${cmd1}")
    
    
    # :(Task):
    # You can run a module task
    # @return Array<Dict>
    $task1 = run_task('demo::hello', $nodes, 'name' => 'Leopoldo Munoz')

    # $task1.ok (Ok method of the list?... weird ruby thing...)
    # Don't forget to validate if !ok
    notice("validation>>> |ok?|: ${$task1.ok}")
    if !$task1.ok {
        return fail("demo::hello executed with error: ${task1.error}")
    }

    # $task1 is a list of inmutable variables:
    # You can access the method target to display the TargetSpec.
    # To access the JSON data sent by the task use [property_name]
    $task1.each |$x| {
        notice("iterator>>> |${x.target}|: ${x[msg]} | ${x[name]} | ${x[status]}")
    }

    $task2 = run_task('demo::error', $nodes, 'reason' => 'Puppet Bolt Plan Demo')
    if !$task2.ok {
        return fail("demo::error executed with error: ${task2.error}")
    }

    # :(?): 
    # This code block will never reach. The previous task returns.
    # (Note: This is a valid syntax to access result data)
    # You can direct access the keys by [index][property_name]
    notice("direct>>> |${task2[0].target}|: ${task2[0][msg]} | ${task2[0][name]} | ${task2[0][status]}")
}
