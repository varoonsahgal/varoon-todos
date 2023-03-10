import React from 'react';
import axios from 'axios';
//this is me doing some application development

export default class PersonList extends React.Component {
  state = {
    persons: []
  }

  componentDidMount() {
    axios.get(`https://p9q7a06dy8.execute-api.us-west-2.amazonaws.com/prod/get-todo`)
      .then(res => {
        const persons = res.data.body;
        this.setState({ persons });
      })
  }

  render() {
    return (
      <ul>
        {
          this.state.persons
            .map(person =>
              <li key={person.id}>{person.id}{person.name}</li>
            )
        }
      </ul>
    )
  }
}
