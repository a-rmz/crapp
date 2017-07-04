import React from 'react';
import { StyleSheet, Text, Button, View } from 'react-native';

export default class App extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      toggleLabel: false
    };
    this.onPressToggle = this.onPressToggle.bind(this);
  }

  onPressToggle() {
    this.setState(previousState => ({
      toggleLabel: !previousState.toggleLabel
    }));
  }

  render() {
    return (
      <View style={styles.container}>
        <Text>I'm just a clickbait</Text>
        <Button
          onPress={this.onPressToggle}
          title="Click me 😏"
          color="#377599"
          accessibilityLabel="Click me, baby!"
        />
        { this.state.toggleLabel ?
          <Text>Hi c:</Text> :
          null
        }
      </View>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff',
    alignItems: 'center',
    justifyContent: 'center',
  },
});
