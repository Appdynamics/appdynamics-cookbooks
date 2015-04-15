if [[ $# == 0 ]]; then
    KITCHEN_SUBCOMMAND="verify"
else
    KITCHEN_SUBCOMMAND="$*"
fi

report() {
    local message=$1
    shift

    echo -n "Running $message... "

    local results=$(bundle exec $* 2>&1)

    if [[ $? == 0 ]]; then
        echo OK!
    else
        echo Failed
        echo
        echo $results
        echo
    fi
}

report "RSpec" rspec spec
report "Foodcritic" foodcritic --epic-fail any .
report "Rubocop" rubocop

if [ "$KITCHEN_SUBCOMMAND" != "--no-kitchen" ]; then
    echo "Running Kitchen ($KITCHEN_SUBCOMMAND)..."
    bundle exec kitchen $KITCHEN_SUBCOMMAND
fi
